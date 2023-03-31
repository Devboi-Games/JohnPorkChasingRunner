using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

public class Skin : MonoBehaviour
{
    private enum UnlockMethod { Ad, Score }
    [SerializeField] private UnlockMethod unlockMethod;
    [SerializeField] private float price;

    public float Price { get => price; }
    public bool IsUnlocked { get; set; } = false;
    public bool UnlockedWithAd { get => unlockMethod == UnlockMethod.Ad; }
    public bool UnlockedWithScore { get => unlockMethod == UnlockMethod.Score; }

    public void Unlock(int index)
    {
        if (IsUnlocked) return;
        switch (unlockMethod)
        {
            case UnlockMethod.Ad:
                {
                    UnlockWithAd(index);
                }
                break;
            case UnlockMethod.Score:
                {
                    UnlockWithScore(index);
                }
                break;
            default:
                break;
        }
    }

    private void UnlockWithAd(int index)
    {
        Debug.LogError("Implement Ads First");
    }

    private void UnlockWithScore(int index)
    {
        if (ScoreManager.Instance.SpendScore(price))
        {
            IsUnlocked = true;
            SaveAndLoadManager.SaveUnlockedSkin(index);
        }
    }
}
