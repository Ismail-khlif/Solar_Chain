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
    struct PartnerOffer{
        string description;
        bool choixPart;
        mapping(string =>uint)Paneaus;
    }
 PartnerOffer[] public PartnerOffers;
Request[] public requests;
address public manager ;

mapping(address =>bool) public approvers;
uint public approvsCount;
uint ProjectAmount;


function Projet() public {
manager=msg.sender;
}

modifier restricted(){
require(msg.sender==manager);
_;
}
//function createOfferPAr(string description){
//PartnerOffer memory newOffre = PartnerOffer({
//
//});
//PartnerOffers.push(newOffre);
//
//}

function createRequest(string description,uint value ,address recipient) public restricted{

Request memory newRequest = Request({
description : description,
value:value,
recipient:recipient,
complete : false,
approvalCount :0
});
requests.push(newRequest);
}

function contribute() public payable returns(uint){
require(msg.value>0);
approvers[msg.sender]=true;
approvsCount++;
return(
msg.value/ProjectAmount*100 //percentage of the amount for the project
);

}
function approveRequest(uint index)public {
Request storage request =requests[index];

require(approvers[msg.sender]);
require(!request.approvals[msg.sender]);
request.approvals[msg.sender]=true;
request.approvalCount ++ ;

}

function finalizeRequest(uint index) public restricted{
Request storage request =requests[index];
require(!request.complete);
require(request.approvalCount>(approvsCount/2));
request.recipient.transfer(request.value);
request.complete =true;
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