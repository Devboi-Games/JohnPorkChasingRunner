using UnityEngine;

public class TurretWall : MonoBehaviour
{
    public GameObject cvm;
    public Turret turretScript;
    public GameObject otherCamerasGroup;
    public Transform playerSeat;

    public Transform[] sideEnemyParents;

    private void Start()
    {
        otherCamerasGroup = GameObject.Find("/CM ClearShot1");
    }

    public void StartTurret()
    {
        otherCamerasGroup.SetActive(false);
        cvm.SetActive(true);
        turretScript.enabled = true;
        if (sideEnemyParents.Length > 0)
        {

            for (int i = 0; i < sideEnemyParents.Length; i++)
            {
                int insideEnemies = sideEnemyParents[i].childCount;

                for (int j = 0; j < insideEnemies; j++)
                {
                    sideEnemyParents[i].GetChild(0).GetComponent<Enemy>().KillEnemy();
                }
            }
        }

        Destroy(this.gameObject);
    }
}
