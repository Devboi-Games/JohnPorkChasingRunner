using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WinMenu : MonoBehaviour
{
    [SerializeField] private GameStateManager gameStateManager;

    private void Start()
    {
        gameStateManager.onGameStateChanged += GameStateManager_onGameStateChanged;
        gameObject.SetActive(false);
    }

    private void GameStateManager_onGameStateChanged(object sender, GameStateManager.OnGameStateChangedEventArgs e)
    {
        gameObject.SetActive(e._currentEndGameState == GameStateManager.EndGameState.Win);
    }
}
