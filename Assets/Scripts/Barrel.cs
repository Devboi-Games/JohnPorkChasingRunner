using System.Collections.Generic;
using UnityEngine;

public class Barrel : MonoBehaviour
{
    public int force;
    public int radius;
    public Transform centerPoint;
    public LayerMask layerMask;
    public LayerMask layerMaskForBody;
    public GameObject blastFx;
    public ParticleSystem blastFx2;
    public List<Collider> colliders;
    public List<Rigidbody> rigidBodies;

    Collider selfCollider;

    private void Start()
    {
        PiecesOff(); 
        blastFx2.Stop();
        selfCollider = this.GetComponent<Collider>();
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Bullet"))
        {
            GameManager.instance.CameraHighPointView();
            Collider[] colls = Physics.OverlapSphere(centerPoint.position, radius, layerMask);

            foreach (Collider collsIn in colls)
            {
                if(collsIn)
                {
                    collsIn.GetComponent<Enemy>().EnemyDieWithRagdoll();
                }
            }

            //Instantiate(blastFx, this.transform.position, Quaternion.identity);
            blastFx2.Play();

            Collider[] colls2 = Physics.OverlapSphere(centerPoint.position, radius, layerMaskForBody);

            foreach (Collider collsIn in colls2)
            {
                Rigidbody rb = collsIn.GetComponent<Rigidbody>();

                if(rb)
                {
                    rb.AddExplosionForce(force, centerPoint.position, radius);
                    rb.AddForce(Vector3.up * 10, ForceMode.Impulse);
                }
            }
            GameManager.instance.SlowDown();
            Destroy(this.gameObject);
        }
    }

    void PiecesOff()
    {
        for (int i = 0; i < colliders.Count; i++)
        {
            rigidBodies[i].isKinematic = true;
            rigidBodies[i].useGravity = false;
            colliders[i].isTrigger = true;
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(centerPoint.position, radius);
    }
}
