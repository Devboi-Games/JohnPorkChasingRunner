using UnityEngine;

public class RoadTrigger : MonoBehaviour
{
    public Transform roadTriggerParent;
    public Transform allEnemiesBehind;

    Transform currentEnemy;

    public void OtherEnemiesStartRunning()
    {
        int childCount = roadTriggerParent.childCount;

        for (int i = 0; i < childCount; i++)
        {
            currentEnemy = roadTriggerParent.GetChild(0).transform;
            Enemy enemy = currentEnemy.GetComponent<Enemy>();
            enemy.playerPos = GameObject.Find("/Player parent").transform.GetChild(0);
            enemy.SetDestination();
            currentEnemy.parent = allEnemiesBehind.transform;
        }
        Destroy(roadTriggerParent.gameObject);
        Destroy(this.gameObject);
    }
}
