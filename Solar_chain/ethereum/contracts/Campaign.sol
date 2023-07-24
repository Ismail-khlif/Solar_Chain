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

}