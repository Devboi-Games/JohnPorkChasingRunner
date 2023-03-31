using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScoreManager : MonoBehaviour
{
    //[SerializeField] private Player player;
    [SerializeField] private TMPro.TextMeshProUGUI scoreText;
    [SerializeField] private float killValue;

    private float score;
    public static ScoreManager Instance { get; private set; }

    private void Awake()
    {
        Instance = this;
    }



    private void Start()
    {
        score = SaveAndLoadManager.LoadScore();
        UpdateScoreText();
        //player.onGotAKill += Player_onGotAKill; ;
    }

    private void Player_onGotAKill(object sender, EventArgs e)
    {
        score += killValue;
        UpdateScoreText();
    }

    private void UpdateScoreText()
    {
        scoreText.text = $"{score} $";
    }

    public bool SpendScore(float amount)
    {
        if (score - amount >= 0)
        {
            score -= amount;
            UpdateScoreText();
            AudioManager.Instance.PlaySuccess();
            //Sounds
            return true;
        }
        AudioManager.Instance.PlayFail();
        //Sounds
        return false;
    }

    private void OnApplicationPause(bool pause)
    {
        if (pause)
        {
            SaveAndLoadManager.SaveScore(score);
        }
    }
}
