// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

// Calling parent functions:
// 1. Direct
// 2. super

/* 
    E -> Base contract
 /    \
F      G
 \    /
   H
*/

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    // First way - Direct
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo();
    }

    // Second way - super
    function bar() public virtual override {
        emit Log("F.bar");
        super.bar();
    }
}

contract G is E {
    // First way - Direct
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo();
    }

    // Second way - super
    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    }
}

contract H is F, G {
    // Calls only F function
    function foo() public override(F, G) {
        F.foo();
    }

    // Calls both F and G functions
    function bar() public override(F, G) {
        super.bar();
    }
}
