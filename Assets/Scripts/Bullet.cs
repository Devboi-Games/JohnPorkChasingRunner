using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bullet : MonoBehaviour
{
    public float speed;

    private void Start()
    {
        Destroy(this.gameObject, 2);
    }

    private void Update()
    {
        this.transform.Translate(Vector3.forward * speed * Time.deltaTime, Space.Self);
    }
}
