// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Tickets {
    uint256 constant TOTAL_TICKETS = 10;
    address public owner;

    struct Ticket {
        uint256 id;
        uint256 price;
        address owner; 
        bool purchased; // New field to track if the ticket is purchased
    }

    Ticket[TOTAL_TICKETS] public tickets;

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
        for (uint256 i = 0; i < TOTAL_TICKETS; i++) {
            tickets[i].id = i;
            tickets[i].price = 1 ether / 10; // Set the ticket price (0.1 ETH)
            tickets[i].owner = address(0); // Initialize owner to zero address
            tickets[i].purchased = false; // Initialize purchased status
        }
    }

    function buyTicket(uint256 ticketId) public payable {
        require(msg.value == tickets[ticketId].price, "Incorrect Ether sent");
        require(tickets[ticketId].owner == address(0), "Ticket already sold");

        // Mark the ticket as purchased and set the owner
        tickets[ticketId].owner = msg.sender;
        tickets[ticketId].purchased = true; // Update purchased status

        // Optionally, you could add logic to transfer Ether to the contract owner
    }

    function getTicket(uint256 ticketId) public view returns (uint256, uint256, address, bool) {
        Ticket memory ticket = tickets[ticketId];
        return (ticket.id, ticket.price, ticket.owner, ticket.purchased); // Return all relevant ticket data
    }
}
