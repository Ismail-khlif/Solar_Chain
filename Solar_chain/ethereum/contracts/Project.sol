pragma solidity ^0.8.20;

contract Campaign {
    struct CampaignInfo {
        address projectOwner;
        uint consomationYear;
        address recipient;
        string description;
        uint limiteconsomation;
        uint joursOffre;
    }
    
    CampaignInfo[] public campaigns;
    
    constructor(address recipient , uint consomationYear, string memory description, uint limiteconsomation, uint joursOffre ) {
        createCampaign(msg.sender, consomationYear, recipient, description, limiteconsomation, joursOffre);
    }
    
    function createCampaign(address projectOwner, uint consomationYear, address recipient, string memory description, uint limiteconsomation, uint joursOffre) public {
        CampaignInfo memory newCampaign = CampaignInfo({
            projectOwner: projectOwner,
            consomationYear: consomationYear,
            recipient: recipient,
            description: description,
            limiteconsomation: limiteconsomation,
            joursOffre : joursOffre
        });
        campaigns.push(newCampaign);
    }
    
    function getCampaignCount() public view returns (uint256) {
        return campaigns.length;
    }
}
