using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[DefaultExecutionOrder(-10)]
public class SaveAndLoadManager : MonoBehaviour
{
    private static PlayerData playerData;

    private void Awake()
    {
        PlayerData.Load();
        playerData = PlayerData.Get();
    }

    public static void SaveLevel(int currentLevel)
    {
        playerData.currentLevel = currentLevel;
        PlayerData.Save();
    }

    public static int LoadLevel()
    {
        return playerData.currentLevel;
    }
}
