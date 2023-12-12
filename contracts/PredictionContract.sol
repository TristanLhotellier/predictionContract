// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PrediContrat  {
    address public owner;
    uint256 public predictionWindow; // Duration of the prediction window in seconds
    uint256 public predictionEnd; // Prediction end time
    bool public predictionsClosed; // Prediction closure indicator

    enum Prediction { None, Up, Down }

    struct BetInfo {
        Prediction prediction;
        uint256 amount;
        bool claimed;
    }

    mapping(address => BetInfo) public bets;
    AggregatorV3Interface public priceFeed;

    event BetPlaced(address indexed user, Prediction prediction, uint256 amount);
    event BetClaimed(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier openPredictions() {
        require(block.timestamp < predictionEnd && !predictionsClosed, "Predictions are closed");
        _;
    }

    modifier closedOrClaimedPredictions() {
        require(block.timestamp >= predictionEnd || predictionsClosed, "Predictions are still open");
        require(bets[msg.sender].claimed, "Bet not reclaimed");
        _;
    }

    constructor(
        address _owner,
        uint256 _predictionWindow,
        address _priceFeedAddress
    ) {
        owner = _owner;
        predictionWindow = _predictionWindow;
        predictionEnd = block.timestamp + _predictionWindow;
        predictionsClosed = false;
        priceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    function placeBet(Prediction _prediction) external payable openPredictions {
        require(_prediction != Prediction.None, "Invalid prediction");

        bets[msg.sender] = BetInfo({
            prediction: _prediction,
            amount: msg.value,
            claimed: false
        });

        emit BetPlaced(msg.sender, _prediction, msg.value);
    }

    function closePredictions() external onlyOwner openPredictions {
        predictionsClosed = true;
    }

    function claim() external closedOrClaimedPredictions {
        require(bets[msg.sender].amount > 0, "No bet placed");

        uint256 userPrediction = bets[msg.sender].prediction == Prediction.Up ? 1 : 0;
        (, int256 price, , , ) = priceFeed.latestRoundData();

        if ((price > 0 && userPrediction == 1) || (price < 0 && userPrediction == 0)) {
            // User wins
            uint256 winnings = bets[msg.sender].amount * 2;
            payable(msg.sender).transfer(winnings);
            bets[msg.sender].claimed = true;
            emit BetClaimed(msg.sender, winnings);
        } else {
            // User loses
            bets[msg.sender].claimed = true;
        }
    }
}