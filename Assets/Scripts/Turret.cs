using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Turret : MonoBehaviour
{
    public GameObject bulletPrefab;
    public GameObject tapTuto;
    public Transform bulletPoint;
    public float swipeSpeed;
    public float timer;
    public float yLimiter;

    Vector3 fingerPosition1;
    Vector3 fingerPosition2;
    float time;
    float yClamp;
    float diff;
    bool startFiring;


    private void OnEnable()
    {
        tapTuto.SetActive(true);
    }

    private void Update()
    {

        if(Input.GetMouseButtonDown(0) && !startFiring)
        {
            startFiring = true;
            tapTuto.SetActive(false);
        }

        if(Input.GetMouseButtonDown(0) && startFiring)
        {
            fingerPosition1 = Camera.main.ScreenToViewportPoint(Input.mousePosition);
        }

        if(Input.GetMouseButton(0) && startFiring)
        {
            fingerPosition2 = Camera.main.ScreenToViewportPoint(Input.mousePosition);
            diff += (fingerPosition2.x - fingerPosition1.x) * swipeSpeed * Time.deltaTime;
            float diff2 = Mathf.Clamp(diff, -yLimiter, yLimiter);
            this.transform.localEulerAngles = new Vector3(0, diff2, 0);

            fingerPosition1 = fingerPosition2;


            if(Time.time > time)
            {
                Instantiate(bulletPrefab, bulletPoint.position, bulletPoint.rotation);
                time = Time.time + timer;
                GameManager.instance.PlayBugGunShot();
            }
        }
    }
}
