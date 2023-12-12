// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "truffle/Assert.sol";
// import "truffle/DeployedAddresses.sol";
import "../contracts/PredictionContract.sol";
import "forge-std/Test.sol";

contract TestPredictionContract {
    PredictionContract predictionContract;
    address owner;
    address user1;

    function beforeAll() public {
        owner = address(this);
        user1 = address(0x1); // Test address for testing

        predictionContract = new PredictionContract(owner, 60, address(0x123));
    }

    function testPlaceBet() public {
        predictionContract.placeBet(PredictionContract.Prediction.Up);

        PredictionContract.BetInfo memory bet = predictionContract.bets(owner);

        assertEq(uint(bet.prediction), uint(PredictionContract.Prediction.Up), "Incorrect prediction");
        assertEq(bet.amount, 0, "Incorrect bet amount");
        assertEq(bet.claimed, false, "The bet should not be reclaimed");
    }

    function testClosePredictions() public {
        predictionContract.closePredictions();

        bool predictionsClosed = predictionContract.predictionsClosed();

        assertEq(predictionsClosed, true, "The predictions should be closed");
    }

    function testClaimWinner() public {
        predictionContract.placeBet(PredictionContracttracttracttracttract.Prediction.Up);
        predictionContract.closePredictions();
        predictionContract.claim();

        PredictionContract.BetInfo memory bet = predictionContract.bets(owner);

        assertEq(bet.claimed, true, "The bet should be reclaimed");
    }

    function testClaimLoser() public {
        predictionContract.placeBet(PredictionContract.Prediction.Down);
        predictionContract.closePredictions();
        predictionContract.claim();

        PredictionContract.BetInfo memory bet = predictionContract.bets(owner);

        assertEq(bet.claimed, true, "The bet should be reclaimed");
    }

    function testClaimWithoutBet() public {
        predictionContract.closePredictions();
        predictionContract.claim();

        PredictionContract.BetInfo memory bet = predictionContract.bets(owner);

        assertEq(bet.claimed, true, "The bet should be reclaimed");
    }

    function testPlaceBetInvalidPrediction() public {
        try predictionContract.placeBet(PredictionContract.Prediction.None) {
            Assert.fail("Should fail with invalid prediction");
        } catch Error(string memory) {
            Assert.ok(true, "Should fail with invalid prediction");
        }
    }
}