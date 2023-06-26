// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

// 2 ways to call parent constructor

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// First way
contract U is S("S"), T("T") {

}

// Second way
// Order of execution:
// S
// T
// V
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

// Combination of both
contract W is S, T("T") {
    constructor(string memory _name) S(_name) {}
}
