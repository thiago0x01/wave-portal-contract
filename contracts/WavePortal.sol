// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) public wavesByAddress;

    constructor() {
        console.log("Ueba, eu sou um contrato e eu sou inteligente");
    }

    function wave() public {
        totalWaves += 1;
        wavesByAddress[msg.sender] += 1;
        console.log("%s acenou!", msg.sender);
        console.log("%s tem %s aceno(s)!", msg.sender, wavesByAddress[msg.sender]);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Temos um total de %d acenos", totalWaves);
        return totalWaves;
    }
}
