# Crowdfunding Contract
contract Crowdfunding:
    campaigns: public(map(uint256, Campaign))
    campaign_count: uint256
    owner: address

    struct Campaign:
        name: str
        goal: uint256
        deadline: uint256
        funds_collected: uint256
        is_open: bool
        creator: address

    def __init__():
        self.owner = msg.sender
        self.campaign_count = 0

    def createCampaign(name: str, goal: uint256, duration: uint256) -> uint256:
        self.campaign_count += 1
        self.campaigns[self.campaign_count] = Campaign({
            name: name,
            goal: goal,
            deadline: block.timestamp + duration,
            funds_collected: 0,
            is_open: True,
            creator: msg.sender
        })
        return self.campaign_count

    # Other functions: contribute, checkGoalReached, finalizeCampaign, getDetails, etc.

    # Additional functions for Crowdfunding functionalities (if needed)
