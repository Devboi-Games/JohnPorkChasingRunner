using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelLoadingManager : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI levelText;
    [SerializeField] private LoadingPanel loadingPanel;
    [SerializeField] private GameObject[] levels;
    private int currentLevel;

    private void Start()
    {
        loadingPanel.onHidden += LoadingPanel_onHidden;
        currentLevel = SaveAndLoadManager.LoadLevel();
        levels[currentLevel - 1].SetActive(true);
        SetLevelText();
    }

    private void LoadingPanel_onHidden(object sender, EventArgs e)
    {
        currentLevel++;
        SaveAndLoadManager.SaveLevel(currentLevel);
        BE_ReloadLevel();
    }

    private void SetLevelText()
    {
        levelText.text = $"Level {currentLevel}";
    }

    public void LoadNextLevel()
    {
        loadingPanel.Show();
    }
    public void BE_ReloadLevel()
    {
        StartCoroutine(COR_Restart());
        IEnumerator COR_Restart()
        {
            yield return new WaitForSeconds(.15f);
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.N))
        {
            LoadNextLevel();
        }
    }
}
