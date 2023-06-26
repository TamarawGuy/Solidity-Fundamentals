// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

// private - only inside contract
// internal - only inside contract and child contracts
// public - inside and outside contract
// external - only outside contract

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() private pure returns (uint) {
        return 100;
    }

    function publicFunc() private pure returns (uint) {
        return 200;
    }

    function externalFunc() private pure returns (uint) {
        return 300;
    }

    function examples() external view {
        uint sum = x + y + z;

        privateFunc();
        internalFunc();
        publicFunc();
        // cannot access externalFunc();
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() view examples {
        // cannot access x;
        y = 10;
        z = 20;
        // cannot access privateFunc();
        internalFunc();
        publicFunc();
        // cannot access externalFunc();
    }
}
