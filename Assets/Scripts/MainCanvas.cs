using UnityEngine;
using UnityEngine.SceneManagement;

public class MainCanvas : MonoBehaviour
{
    private void Start()
    {
        //SceneManager.LoadScene(1);
        int level = PlayerPrefs.GetInt("Level no.", 1);
        if (level >= SceneManager.sceneCountInBuildSettings)
        {
            level = Random.Range(1, SceneManager.sceneCountInBuildSettings);
        }
        SceneManager.LoadScene(level);

    }
}
