using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameStateManager : MonoBehaviour
{
    public class OnGameStateChangedEventArgs : EventArgs
    {
        public State _currentState;
        public EndGameState _currentEndGameState;
    }

    public enum State { Idle, Started, Ended }
    public enum EndGameState { Lose, Win }

    //[SerializeField] private Player player;
    [SerializeField] private FinishLine finishLine;
    [SerializeField] private ControlPanel controlPanel;
    [SerializeField] private CallStateManager callStateManager;

    private State currentState = State.Idle;
    private OnGameStateChangedEventArgs gameStateChangedEventArgs = new OnGameStateChangedEventArgs();

    public event EventHandler<OnGameStateChangedEventArgs> onGameStateChanged;

    private void Start()
    {
        callStateManager.onCallStateChanged += CallStateManager_onCallStateChanged;
        //player.onIsDead += Player_onIsDead;
        finishLine.onIsCrossed += FinishLine_onIsCrossed;
    }

    private void CallStateManager_onCallStateChanged(object sender, CallStateManager.OnCallStateChangedEventArgs e)
    {
        if (e._currentCallState == CallStateManager.CallState.Ended)
        {
            SetGameState(State.Started);
        }
    }

    private void FinishLine_onIsCrossed(object sender, EventArgs e)
    {
        SetEndGameState(EndGameState.Win);
    }

    private void Player_onIsDead(object sender, EventArgs e)
    {
        SetEndGameState(EndGameState.Lose);
    }



    private void SetGameState(State state)
    {
        currentState = state;
        gameStateChangedEventArgs._currentState = currentState;
        onGameStateChanged?.Invoke(this, gameStateChangedEventArgs);
        Debug.Log("State: " + state);
    }

    private void SetEndGameState(EndGameState endState)
    {
        gameStateChangedEventArgs._currentEndGameState = endState;
        SetGameState(State.Ended);
    }
}
