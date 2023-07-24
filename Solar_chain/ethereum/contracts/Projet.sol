pragma solidity ^0.8.20;
contract Projet{

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
    PartnerOffer[] public PartnerOffers
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
    function createOfferPAr(string description){
        PartnerOffer memory newOffre = PartnerOffer({

        });
        PartnerOffers.push(newOffre);

    }

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

}