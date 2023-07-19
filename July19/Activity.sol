// *** Note: Create separate smart contract for each item *** //

/** 
1.] 
    > Complete the code below: 
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    enum ConnectionTypes {
        Unacquainted,
        Friend,
        Family
    }

    // Create a public mapping called connections which will map an address to a mapping of an address to a ConnectionTypes enum value.

    function connectWith(
        address other,
        ConnectionTypes connectionType
    ) external {
        //In theconnectWith function, create a connection from the msg.sender to the other address.
    }
}

// ======================================= //

/** 
 2.]
    > Create an external, pure function called sumAndAverage that has four uint parameters.
    > Find both the sum and the average of the four numbers. Return these two values in this order as unsigned integers.
*/

// ======================================= //

/**
 3.]
    > Create a public mapping called members which maps an address to a bool. The bool will indicate whether or not the address is currently a member!
    > Create an external function called addMember which takes an address and adds it as a member. You can do this by storing true in the data location corresponding to the address in the members mapping
    > Create an external, view function called isMember which takes an address and returns a bool indicating whether or not the address is a member.
    > Create an external function called removeMember that will take an address and set its corresponding value in the members mapping to false.
 */

// ======================================= //

/**
 4.]
    > Create a public mapping called users that will map an address to a User struct.
    > Create an external function called createUser. This function should create a new user and associate it to the msg.sender address in the users mapping. 
    > The balance of the new user should be set to 100 and the isActive boolean should be set to true.
    > Ensure that the createUser function is called with an address that is not associated with an active user. 
    
    > Create an external function called transfer which takes two parameters: an address for the recipient and a uint for the amount.
    > In this function, transfer the amount specified from the balance of the msg.sender to the balance of the recipient address.
    > Ensure that both addresses used in the transfer function have active users.
    > Ensure that the msg.sender has enough in their balance to make the transfer without going into a negative balance.

 */

// ======================================= //

/**
5.]
    > Create a pure, external function `sum` which takes a fixed size array of **five unsigned integers**.
    > Find the sum of the unsigned integers and return it as a `uint`.
 */
