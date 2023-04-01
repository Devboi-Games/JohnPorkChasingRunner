using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangePlayerSkin : MonoBehaviour
{
    [SerializeField] private Animator animator;
    [SerializeField] private Avatar[] avatars;
    [SerializeField] private GameObject[] skins;
    [SerializeField] private GameObject[] hands;
    private int skinIndex;
    private bool initialized;

    private void Start()
    {
        if (initialized) return;
        skinIndex = PlayerData.Get().selectedSkin;

        animator.avatar = avatars[skinIndex];

        for (int i = 0; i < skins.Length; i++)
        {
            skins[i].SetActive(i == skinIndex);
        }
    }

    public void Init()
    {
        skinIndex = PlayerData.Get().selectedSkin;

        animator.avatar = avatars[skinIndex];

        for (int i = 0; i < skins.Length; i++)
        {
            skins[i].SetActive(i == skinIndex);
        }
        initialized = true;
    }
}
