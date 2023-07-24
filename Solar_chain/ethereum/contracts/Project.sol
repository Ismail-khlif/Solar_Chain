pragma solidity ^0.8.20;

contract Campaign {
    struct CampaignInfo {
        address projectOwner;
        uint consomationYear;
        string description;
        uint limiteconsomation;
        uint joursOffre;
    }
    
    CampaignInfo[] public campaigns;
    
    constructor( uint consomationYear, string memory description, uint limiteconsomation, uint joursOffre ) {
        createCampaign(msg.sender, consomationYear, description, limiteconsomation, joursOffre);
    }

    
    function createCampaign(address projectOwner, uint consomationYear, string memory description, uint limiteconsomation, uint joursOffre) public {
        
        require(consomationYear < limiteconsomation, "Your Limit consomation must be higher than your usual Consomation");
        
        CampaignInfo memory newCampaign = CampaignInfo({
            projectOwner: projectOwner,
            consomationYear: consomationYear,
            description: description,
            limiteconsomation: limiteconsomation,
            joursOffre : joursOffre
        });
        campaigns.push(newCampaign); 
    }
    
    function getCampaignCount() public view returns (uint) {
        return campaigns.length;
    }
}
