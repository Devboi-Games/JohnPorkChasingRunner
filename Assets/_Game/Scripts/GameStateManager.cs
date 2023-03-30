using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameStateManager : MonoBehaviour
{
    public class OnGameStateChangedEventArgs : EventArgs
    {
        public State _currentState;
    }
    public enum State { Idle, Started, Ended }

    [SerializeField] private ControlPanel controlPanel;
    private State currentState = State.Idle;
    private OnGameStateChangedEventArgs gameStateChangedEventArgs = new OnGameStateChangedEventArgs();

    public event EventHandler<OnGameStateChangedEventArgs> onGameStateChanged;

    private void Start()
    {
        controlPanel.onDragToStartGame.AddListener(ControlPanel_onDragToStartGame);
    }

    private void ControlPanel_onDragToStartGame()
    {
        SetGameState(State.Started);
        controlPanel.onDragToStartGame.RemoveListener(ControlPanel_onDragToStartGame);
    }

    private void SetGameState(State state)
    {
        currentState = state;
        gameStateChangedEventArgs._currentState = currentState;
        onGameStateChanged?.Invoke(this, gameStateChangedEventArgs);
        Debug.Log("State: " + state);
    }
}
