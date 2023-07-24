pragma solidity ^0.8.20;

contract Campaign {
    struct CampaignInfo {
        address projectOwner; uint value; address recipient;
    }
    
    CampaignInfo[] public campaigns;
    
    constructor(string memory , uint256 ) {
        createCampaign(, );
    }
    
    function createCampaign(address projectOwner, uint value, address recipient) public {
        CampaignInfo memory newCampaign = CampaignInfo({
            projectOwner: projectOwner,
            value: value,
            recipient: recipient
        });
        campaigns.push(newCampaign);
    }
    
    function getCampaignCount() public view returns (uint256) {
        return campaigns.length;
    }
}
