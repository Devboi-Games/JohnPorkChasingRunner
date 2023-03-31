using UnityEngine;

public class AddPlayer : MonoBehaviour
{
    public GameObject particleFx;


    public void DestroyThis()
    {
        Instantiate(particleFx, this.transform.position, particleFx.transform.rotation);
        Destroy(this.gameObject);
    }
}
