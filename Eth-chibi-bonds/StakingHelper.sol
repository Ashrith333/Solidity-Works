// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.7.5;

import "./interfaces/IStaking.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakingHelper {

    address public immutable staking;
    address public immutable chibi;

    constructor ( address _staking, address _chibi ) {
        require( _staking != address(0) );
        staking = _staking;
        require( _chibi != address(0) );
        chibi = _chibi;
    }

    function stake( uint _amount ) external {
        IERC20( chibi ).transferFrom( msg.sender, address(this), _amount );
        IERC20( chibi ).approve( staking, _amount );
        IStaking( staking ).stake( _amount, msg.sender );
        IStaking( staking ).claim( msg.sender );
    }
}