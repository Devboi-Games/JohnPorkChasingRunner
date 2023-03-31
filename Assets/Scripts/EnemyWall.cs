using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyWall : MonoBehaviour
{
    public Turret turretScript;
    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.CompareTag("Enemy"))
        {
            turretScript.enabled = false;
            GameManager.instance.DestinationOff();
        }
    }
}
