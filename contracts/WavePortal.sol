// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    mapping(address => uint256) public totalWavesByAddress;
    uint256 private seed;
    mapping(address => uint256) public lastWavedAt;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log(
            "Contrato inteligente para acenar e enviar elogios iniciado..."
        );

        seed = (block.timestamp + block.difficulty) % 100;
    }

    modifier contractHaveMoney(uint256 prizeAmount) {
        require(
            prizeAmount <= address(this).balance,
            "Tentando sacar mais dinheiro que o contrato possui."
        );

        _;
    }

    modifier canWave() {
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Espere 15m"
        );

        _;
    }

    function wave(string memory _message)
        public
        contractHaveMoney(0.0001 ether)
        canWave
    {
        lastWavedAt[msg.sender] = block.timestamp;
        totalWavesByAddress[msg.sender] += 1;

        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("# randomico gerado: %d", seed);

        if (seed <= 50) {
            console.log("%s ganhou!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;

            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Falhou em sacar do dinheiro do contrato.");
        }

        console.log("%s acenou com o elogio '%s'.", msg.sender, _message);
        console.log(
            "%s tem %s aceno(s) com elogio!",
            msg.sender,
            totalWavesByAddress[msg.sender]
        );

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Temos um total de %d acenos com elogio!", waves.length);

        return waves.length;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
}
