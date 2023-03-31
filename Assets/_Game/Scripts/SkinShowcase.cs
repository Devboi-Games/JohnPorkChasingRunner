using DG.Tweening;
using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class SkinShowcase : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI priceText;
    [SerializeField] private TextMeshProUGUI unlockMethodText;
    [SerializeField] private Button selectButton;
    [SerializeField] private Button buyButton;
    [SerializeField] private float moveDuration;
    [SerializeField] private Ease moveEase;
    [SerializeField] private Vector3 center;
    [SerializeField] private Vector3 farLeft;
    [SerializeField] private Vector3 farRight;
    [SerializeField] private Skin[] skins;
    private int currentSkinIndex;
    private Skin currentSkin;


    private void Start()
    {
        LoadSkins();
        currentSkin = skins[currentSkinIndex];
        UpdateButtons();
        UpdatePriceText();
        UpdateUnlockMethodText();
        MoveToCenter(currentSkin.transform);

        selectButton.onClick.AddListener(BE_Select);
        buyButton.onClick.AddListener(BE_Buy);
    }

    private void LoadSkins()
    {
        currentSkinIndex = SaveAndLoadManager.LoadSkin();
        var unlockedSkins = SaveAndLoadManager.LoadUnlockedSkins();

        for (int i = 0; i < unlockedSkins.Count; i++)
        {
            skins[unlockedSkins[i]].IsUnlocked = true;
        }
    }

    public void BE_Select()
    {
        if (currentSkin.IsUnlocked)
        {
            SaveAndLoadManager.SaveSkin(currentSkinIndex);
        }
        gameObject.SetActive(false);
    }

    public void BE_Buy()
    {
        if (!currentSkin.IsUnlocked)
        {
            currentSkin.Unlock(currentSkinIndex);
            if (currentSkin.IsUnlocked)
            {
                SaveAndLoadManager.SaveSkin(currentSkinIndex);
                UpdateButtons();
                UpdatePriceText();
                UpdateUnlockMethodText();
            }
        }
    }

    public void BE_Right()
    {
        MoveRight(currentSkin.transform);

        currentSkinIndex++;
        if (currentSkinIndex >= skins.Length)
        {
            currentSkinIndex = 0;
        }
        currentSkin = skins[currentSkinIndex];


        UpdateButtons();
        UpdatePriceText();
        UpdateUnlockMethodText();

        currentSkin.transform.position = farLeft;
        MoveToCenter(currentSkin.transform);
    }


    public void BE_Left()
    {
        MoveLeft(currentSkin.transform);

        currentSkinIndex--;
        if (currentSkinIndex <= -1)
        {
            currentSkinIndex = skins.Length - 1;
        }
        currentSkin = skins[currentSkinIndex];


        UpdateButtons();
        UpdatePriceText();
        UpdateUnlockMethodText();

        currentSkin.transform.position = farRight;
        MoveToCenter(currentSkin.transform);
    }
    private void MoveRight(Transform currentSkin)
    {
        currentSkin.DOMove(farRight, moveDuration).SetEase(moveEase).OnComplete(() =>
        {
            currentSkin.position = farLeft;
        });
    }

    private void MoveToCenter(Transform currentSkin)
    {
        currentSkin.DOMove(center, moveDuration).SetEase(moveEase);
    }

    private void MoveLeft(Transform currentSkin)
    {
        currentSkin.DOMove(farLeft, moveDuration).SetEase(moveEase).OnComplete(() =>
        {
            currentSkin.position = farRight;
        }); ;
    }

    private void UpdateButtons()
    {
        selectButton.gameObject.SetActive(currentSkin.IsUnlocked);
        buyButton.gameObject.SetActive(!currentSkin.IsUnlocked && currentSkin.UnlockedWithScore);
    }

    private void UpdatePriceText()
    {
        if (!currentSkin.IsUnlocked)
        {
            priceText.text = $"{currentSkin.Price}$";
            priceText.gameObject.SetActive(true);
        }
        else
        {
            priceText.gameObject.SetActive(false);
        }

    }

    private void UpdateUnlockMethodText()
    {
        if (currentSkin.IsUnlocked || currentSkin.UnlockedWithScore)
        {
            unlockMethodText.gameObject.SetActive(false);
            return;
        }
        else
        {
            unlockMethodText.gameObject.SetActive(true);
        }

        unlockMethodText.text = "Watch An Ad To Unlock";

    }


}
