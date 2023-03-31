using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;

    public PlayerParent playerParent;
    public Turret turret;

    public Transform behindEnemyParent;
    public Transform allEnemyParent;
    public int totalEnemies;
    public int enemiesDied;
    public float enemyReducedSpeed;

    public GameObject turretCamera;
    public GameObject cameraParent;
    public List<GameObject> cams;
    public bool finish;
    public bool canChangeCamera;

    public GameObject generalPanel;
    public GameObject levelFailPanel;
    public GameObject levelCompletePanel;
    public GameObject swipText;

    [Header("Audio")]
    public AudioSource audioSourceForGun;
    public AudioSource audioSource;
    public AudioClip shoot;
    public AudioClip bigShoot;
    public AudioClip pickUpGun;
    public AudioClip enemyDie;

    private void Awake()
    {
        instance = this;
    }

    private void Start()
    {
        behindEnemyParent = GameObject.Find("/All enemies behind").transform;
        allEnemyParent = GameObject.Find("/All Enemies parent").transform;
        playerParent = GameObject.Find("/Player parent").GetComponent<PlayerParent>();
        swipText = GameObject.Find("/Canvas/SwipText");
        //audioSource = this.GetComponent<AudioSource>();
        totalEnemies = behindEnemyParent.childCount;
        canChangeCamera = true;

        if (allEnemyParent.childCount > 0)
        {
            for (int i = 0; i < allEnemyParent.childCount; i++)
            {
                totalEnemies += allEnemyParent.GetChild(i).childCount;
            }
        }


    }

    public void EnemyDied()
    {
        enemiesDied++;

        if(totalEnemies <= enemiesDied)
        {
            generalPanel.SetActive(false);
            Debug.Log("Level Complete");
            turret.enabled = false;
            StartCoroutine(DelayForCameraChange());
        }
    }

    public void ReduceEnemySpeed()
    {
        for (int i = 0; i < behindEnemyParent.childCount; i++)
        {
            behindEnemyParent.GetChild(i).GetComponent<NavMeshAgent>().speed = enemyReducedSpeed;
        }
    }

    public void DestinationOff()
    {
        for (int i = 0; i < behindEnemyParent.childCount; i++)
        {
            behindEnemyParent.GetChild(i).GetComponent<Enemy>().NoDestination();
        }
        generalPanel.SetActive(false);
        StartCoroutine(DelayForLevelFail());
    }

    public void CameraChange(int number)
    {
        for (int i = 0; i < cams.Count; i++)
        {
            if (i == number)
            {
                cams[i].SetActive(true);
            }
            else
            {
                cams[i].SetActive(false);
            }
        }
    }

    public void ChangeEnemyTarget()
    {
        Transform playerAt0Pos = playerParent.transform.GetChild(0).transform;

        for (int i = 0; i < behindEnemyParent.childCount; i++)
        {
            behindEnemyParent.GetChild(i).GetComponent<Enemy>().playerPos = playerAt0Pos;
        }
    }

    public void CameraHighPointView()
    {
        StartCoroutine(CameraBackToNormal());
    }

    public void SlowDown()
    {
        Time.timeScale = 0.4f;
        StartCoroutine(TimeBackToNormal());
    }

    public void SwipeTextOff()
    {
        swipText.SetActive(false);
    }


    //===================== Sounds play =====================
    public void PlayShot()
    {
        if (!audioSourceForGun.isPlaying)
        {
            audioSourceForGun.PlayOneShot(shoot);
        }
    }

    public void PlayBugGunShot()
    {
        audioSource.PlayOneShot(bigShoot);
    }

    public void PlayPickUpGun()
    {
        audioSource.PlayOneShot(pickUpGun);
    }

    public void PlayEnemyDie()
    {
        audioSource.PlayOneShot(enemyDie);
    }
    //===================== Sounds play =====================


    IEnumerator TimeBackToNormal()
    {
        yield return new WaitForSeconds(1);
        Time.timeScale = 1f;
    }

    IEnumerator DelayForCameraChange()
    {
        yield return new WaitForSeconds(1.5f);
        playerParent.MakeAllPlayerDance();
        turretCamera.SetActive(false);
        cameraParent.SetActive(true);
        CameraChange(1);

        yield return new WaitForSeconds(2f);
        levelCompletePanel.SetActive(true);

    }
    
    IEnumerator DelayForLevelFail()
    {
        yield return new WaitForSeconds(2);
        levelFailPanel.SetActive(true);
    }

    IEnumerator CameraBackToNormal()
    {
        CameraChange(4);
        canChangeCamera = false;
        yield return new WaitForSeconds(2);
        CameraChange(0);
        canChangeCamera = true;
    }
}
