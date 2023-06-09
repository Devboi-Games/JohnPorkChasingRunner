using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelLoadingManager : MonoBehaviour
{
    [SerializeField] private LoadingPanel loadingPanel;
    [SerializeField] private GameObject[] levels;
    private int currentLevel;

    private void Start()
    {
        loadingPanel.onHidden += LoadingPanel_onHidden;
        currentLevel = SaveAndLoadManager.LoadLevel();
        levels[currentLevel - 1].SetActive(true);
    }

    private void LoadingPanel_onHidden(object sender, EventArgs e)
    {
        ////currentLevel++;
        //if (currentLevel - 1 >= levels.Length)
        //{
        //    currentLevel = 1;
        //}
        //SaveAndLoadManager.SaveLevel(currentLevel);
        LoadNext();
    }

    private void LoadNext()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    }


    public void BE_LoadNextLevel()
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

    //private void Update()
    //{
    //    if (Input.GetKeyDown(KeyCode.N))
    //    {
    //        BE_LoadNextLevel();
    //    }
    //}
}
