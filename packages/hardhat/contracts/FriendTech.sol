// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FriendTech is ERC20 {
    address public owner;

    mapping(address => uint256) private sharePrice;
    mapping(address => uint256) public totalShares;
    mapping(address => bool) public hasVoted;
    uint256 public proposalCount;
    mapping(uint256 => string) public proposals;
    mapping(uint256 => mapping(address => bool)) public votes;

    constructor() ERC20("FriendTech", "FTK") {
        owner = msg.sender;
    }

    function setSharePrice(uint256 price) external {
        require(price > 0, "Price must be greater than zero");
        sharePrice[msg.sender] = price;
    }

    function getSharePrice(address user) public view returns (uint256) {
        return sharePrice[user];
    }

    function setTotalShares(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        totalShares[msg.sender] = amount;
    }

    function getTotalShares(address user) public view returns (uint256) {
        return totalShares[user];
    }

    function vote(uint256 proposalId) external {
        require(totalShares[msg.sender] > 0, "User must own shares to vote");
        require(!hasVoted[msg.sender], "User has already voted for this proposal");

        require(proposalId < proposalCount, "Invalid proposal ID");

        votes[proposalId][msg.sender] = true;
        hasVoted[msg.sender] = true;
    }

    function createProposal(string calldata description) external {
        require(totalShares[msg.sender] > 0, "User must own shares to create a proposal");

        proposals[proposalCount] = description;
        proposalCount++;
    }

    function executeProposal(uint256 proposalId) external {
        require(proposalId < proposalCount, "Invalid proposal ID");

        uint256 forVotes = 0;
        uint256 againstVotes = 0;

        for (uint256 i = 0; i < proposalCount; i++) {
            if (votes[proposalId][msg.sender]) {
                forVotes += totalShares[msg.sender];
            } else {
                againstVotes += totalShares[msg.sender];
            }
        }

        if (forVotes > againstVotes) {
            // Execute proposal logic here
        } else {
            // Proposal rejected
        }
    }

    function buyShares(address seller, uint256 amount) external payable {
        // Existing buyShares logic
    }

    function sellShares(address buyer, uint256 amount) external {
        // Existing sellShares logic
    }

    function transferShares(address to, uint256 amount) external {
        // Existing transferShares logic
    }
}