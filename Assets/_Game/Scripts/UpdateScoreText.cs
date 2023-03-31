using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class UpdateScoreText : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI winScoreText;
    [SerializeField] private float killValue;
    private float score;
    private float thisLevelCoins;

    public static UpdateScoreText Instance { get; private set; }

    private void Awake()
    {
        Instance = this;
    }

    private void Start()
    {
        score = SaveAndLoadManager.LoadScore();
    }

    public void IncreaseScoreText()
    {
        score += killValue;
        thisLevelCoins += killValue;
        winScoreText.text = $"{thisLevelCoins} $";
    }

    private void OnApplicationPause(bool pause)
    {
        if (pause)
        {
            SaveAndLoadManager.SaveScore(score);
        }
    }
}
