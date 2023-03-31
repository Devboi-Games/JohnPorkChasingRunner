using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Gun : MonoBehaviour
{
    public GameObject bulletPrefab;
    public Transform bulletPoint;
    public ParticleSystem muzzleFlash;
    public float timer;

    public float time;

    private void OnEnable()
    {
        time = timer;
    }

    private void Update()
    {
        time -= Time.deltaTime;

        if(time <= 0)
        {
            Instantiate(bulletPrefab, bulletPoint.position, bulletPoint.rotation);
            muzzleFlash.Play();
            GameManager.instance.PlayShot();
            time = timer;
        }
    }
}
