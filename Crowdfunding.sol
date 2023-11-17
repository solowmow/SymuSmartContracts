// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public owner;
    mapping(address => uint256) public contributions;
    uint256 public totalContributions;
    uint256 public fundingGoal;
    bool public fundingGoalReached;
    bool public campaignEnded;

    event ContributionMade(address contributor, uint256 amount);
    event FundingGoalReached(uint256 totalContributions);
    event CampaignEnded(bool successful);

    constructor(uint256 _goal) {
        owner = msg.sender;
        fundingGoal = _goal;
        fundingGoalReached = false;
        campaignEnded = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    modifier campaignNotEnded() {
        require(!campaignEnded, "The campaign has ended.");
        _;
    }

    function contribute() external payable campaignNotEnded {
        require(msg.value > 0, "Contribution amount should be greater than 0");

        contributions[msg.sender] += msg.value;
        totalContributions += msg.value;

        emit ContributionMade(msg.sender, msg.value);

        checkGoalReached();
    }

    function checkGoalReached() internal {
        if (totalContributions >= fundingGoal && !fundingGoalReached) {
            fundingGoalReached = true;
            emit FundingGoalReached(totalContributions);
        }
    }

    function endCampaign() external onlyOwner {
        require(!campaignEnded, "The campaign has already ended.");

        if (totalContributions >= fundingGoal) {
            // Funding goal reached, campaign successful
            campaignEnded = true;
            emit CampaignEnded(true);
        } else {
            // Funding goal not reached, campaign unsuccessful
            campaignEnded = true;
            emit CampaignEnded(false);
        }
    }

    function withdrawFunds() external onlyOwner {
        require(campaignEnded && fundingGoalReached, "The campaign has not ended or the goal is not reached.");

        payable(owner).transfer(address(this).balance);
    }
}
