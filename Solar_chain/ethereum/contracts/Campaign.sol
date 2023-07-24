pragma solidity ^0.8.20;


contract Campaign{

    struct Request{
        string description;
        uint value ;
        address recipient;
        bool complete;
        mapping(address=>bool) approvals;
        uint approvalCount;
    }
    Request[] public requests;
    address public manager ;
    mapping(address =>bool) public approvers;
    uint public approvsCount;



    function contribute() public payable{
        require(msg.value>0);
        approvers[msg.sender]=true;
        approvsCount++;
    } 

     modifier restricted(){
        require(msg.sender==manager);
        _;
    }

    uint256 public consommationTotale;
    uint256 public nombrePersonnes;
    uint256 public surfaceMaison;
    uint256 public nombreChambres;
    mapping(uint256 => Appareil) public appareils;
    uint256 public nombreAppareils;

    struct Appareil {
        string nomAppareil;
        uint256 puissance;
        uint256 heuresUtilisation;
    }
      struct Partenaire {
        string nomPartenaire;
        mapping(string => MarquePanneau) marques;
    }

    struct MarquePanneau {
        uint256 prix;
        uint256 production;
    }

    mapping(address => Partenaire) public partenaires;
    address[] public listePartenaires;


   function calculerPrixInstallation(uint256 _kWClient, address _adressePartenaire, string memory _nomMarque, uint256 _prixPanneau, uint256 _productionPanneau) public pure returns (uint256) {



    uint256 nombrePanneaux = (_kWClient + _productionPanneau -1) / _productionPanneau;


    return  _prixPanneau * nombrePanneaux;


}



    function calculerConsommation(uint256 _nombrePersonnes, uint256 _surfaceMaison, uint256 _nombreChambres) public {
        nombrePersonnes = _nombrePersonnes;
        surfaceMaison = _surfaceMaison;
        nombreChambres = _nombreChambres;

        uint256 consommationBase = (nombrePersonnes * 1000) + (surfaceMaison * 100);

        consommationTotale += consommationBase;
    }

    function ajouterAppareil(string memory _nomAppareil, uint256 _puissance, uint256 _heuresUtilisation) public {
        // Ajouter l'appareil à la consommation totale
        uint256 consommationAppareil = _puissance * _heuresUtilisation;
        consommationTotale += consommationAppareil;

        // Ajouter l'appareil au mapping des appareils
        appareils[nombreAppareils] = Appareil(_nomAppareil, _puissance, _heuresUtilisation);
        nombreAppareils++;
    }

    function getConsommationParAppareil(uint256 index) public view returns (string memory, uint256) {
        require(index < nombreAppareils, "Index invalide");
        return (appareils[index].nomAppareil, appareils[index].puissance * appareils[index].heuresUtilisation);
    }

function ajouterPartenaire(string memory _nomPartenaire, address _adressePartenaire) public {
        Partenaire storage partenaire = partenaires[_adressePartenaire];
        partenaire.nomPartenaire = _nomPartenaire;
        listePartenaires.push(_adressePartenaire);
    }

    function ajouterMarquePanneau(address _adressePartenaire, string memory _nomMarque, uint256 _prix, uint256 _production) public {
        Partenaire storage partenaire = partenaires[_adressePartenaire];
        partenaire.marques[_nomMarque] = MarquePanneau(_prix, _production);
    }

}

