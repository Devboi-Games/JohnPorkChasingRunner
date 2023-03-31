using System.Collections.Generic;
using UnityEngine;

public class Obstacles : MonoBehaviour
{
    public List<GameObject> objects;
    public Animator anim;
    public Collider ownCollider;
    public int counter;

    public bool walls;

    private void Start()
    {
        anim = this.GetComponentInParent<Animator>();
        ownCollider = this.GetComponent<Collider>();
    }
    // Start is called before the first frame update
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Enemy"))
        {
            counter++;
            other.gameObject.GetComponent<Enemy>().EnemyDie();
            if (counter >= 2)
            {
                if (!walls)
                {
                    DestroyThisObject();
                }
                else
                {
                    Destroy(this.gameObject);
                }
            }
        }
    }

    void DestroyThisObject()
    {
        if (anim)
        {
            anim.enabled = false;
        }
        ownCollider.enabled = false;
        for (int i = 0; i < objects.Count; i++)
        {
            objects[i].AddComponent<Rigidbody>();
            MeshCollider meshcol = objects[i].AddComponent<MeshCollider>();
            meshcol.convex = true;
        }
        Destroy(this.transform.parent.gameObject, 2);
    }
}
