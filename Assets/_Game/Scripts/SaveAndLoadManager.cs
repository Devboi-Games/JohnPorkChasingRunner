using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
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

    public static void SaveScore(float score)
    {
        playerData.score = score;
        PlayerData.Save();
    }

    public static float LoadScore()
    {
        return playerData.score;
    }

    public static void SaveSkin(int skin)
    {
        playerData.selectedSkin = skin;
        PlayerData.Save();
    }

    public static int LoadSkin()
    {
        return playerData.selectedSkin;
    }

    public static void SaveUnlockedSkin(int index)
    {
        playerData.unlockedSkins.Add(index);
        PlayerData.Save();
    }

    public static List<int> LoadUnlockedSkins()
    {
        return playerData.unlockedSkins.ToList();
    }
}
