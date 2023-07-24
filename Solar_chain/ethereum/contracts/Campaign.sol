pragma solidity ^0.8.20;

contract Project{
    
    address public projectOwner;



    function Project (address projectOwner, ) public {
        projectOwner = projectOwner;
    }
}