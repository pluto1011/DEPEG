// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {Id, Pair, PairLibrary} from "../libraries/Pair.sol";
import {IErrors} from "./../interfaces/IErrors.sol";
import {MathHelper} from "./../libraries/MathHelper.sol";
import {IExchangeRateProvider} from "./../interfaces/IExchangeRateProvider.sol";

/**
 * @title ExchangeRateProvider Contract
 * @author Cork Team
 * @notice Contract for managing exchange rate
 */
contract ExchangeRateProvider is IErrors, IExchangeRateProvider {
    using PairLibrary for Pair;

    address public CONFIG; // malicious!!

    mapping(bytes32 => uint256) internal exchangeRate;

    /**
     * @dev checks if caller is config contract or not
     */
    function onlyConfig() internal {
        if (msg.sender != CONFIG) {
            revert IErrors.OnlyConfigAllowed();
        }
    }

    function setConfig() external {
        CONFIG = msg.sender;
    }

    function rate() external view returns (uint256) {
        return 0; // For future use
    }

    function rate(bytes32 id) external view returns (uint256) {
        return exchangeRate[id];
    }

    /**
     * @notice updates the exchange rate of the pair
     * @param id the id of the pair
     * @param newRate the exchange rate of the DS, token that are non-rebasing MUST set this to 1e18, and rebasing tokens should set this to the current exchange rate in the market
     */
    function setRate(bytes32 id, uint256 newRate) external {
        exchangeRate[id] = newRate;
    }
}
