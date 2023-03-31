using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;

public class CanvasScript : MonoBehaviour
{
    public TextMeshProUGUI levelText;

    int levelNo;
    private void Start()
    {
        //levelNo = SceneManager.GetActiveScene().buildIndex;
        levelNo = PlayerPrefs.GetInt("Level no.", 1);
        levelText.text = "Level " + levelNo.ToString();
        //pluginScript.Instance.LevelStart(levelNo.ToString());
    }

    public void Retry()
    {
        //pluginScript.Instance.LevelFail(levelNo.ToString());
        SceneManager.LoadScene(levelNo);
        //if (ISManager.instance)
        //{
        //    ISManager.instance.ShowInterstitialAds();
        //}
    }

    public void Reload()
    {
        SceneManager.LoadScene(levelNo);
        //if (ISManager.instance)
        //{
        //    ISManager.instance.ShowInterstitialAds();
        //}
    }

    public void Next()
    {
        levelNo++;
        PlayerPrefs.SetInt("Level no.", levelNo);
        //pluginScript.Instance.LevelCompleted(levelNo.ToString());
        int rand = levelNo;
        if (levelNo >= SceneManager.sceneCountInBuildSettings)
        {
            rand = Random.Range(1, SceneManager.sceneCountInBuildSettings);
        }
        SceneManager.LoadScene(rand);
        //if (ISManager.instance)
        //{
        //    ISManager.instance.ShowInterstitialAds();
        //}
    }
}
