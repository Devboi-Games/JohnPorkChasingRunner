using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Enemy : MonoBehaviour
{
    public NavMeshAgent navMeshAgent;
    public Transform playerPos;
    public Animator anim;
    public ParticleSystem enemyDeadRingFxPS;
    public Collider selfCollider;
    public Rigidbody selfRigidbody;
    public List<Rigidbody> rbs;
    public List<Collider> colls;

    bool gotTheDestination;
    bool dead;
    bool moveUp;

    private void Start()
    {
        selfRigidbody = this.GetComponent<Rigidbody>();
        selfCollider = this.GetComponent<Collider>();
        navMeshAgent = this.GetComponent<NavMeshAgent>();
        anim = this.GetComponent<Animator>();
        playerPos = GameObject.Find("/Player parent/Player").transform;
        DeactivateRagdoll();
    }

    private void Update()
    {
        if (gotTheDestination)
        {
            navMeshAgent.SetDestination(playerPos.position);
        }

        if (moveUp)
        {
            this.transform.Translate(Vector3.up * 2.5f * Time.deltaTime);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Bullet") && !dead)
        {

            Destroy(other.gameObject);
            KillEnemy();
            UpdateScoreText.Instance.IncreaseScoreText();
        }

        if (other.gameObject.CompareTag("Ladder"))
        {
            gotTheDestination = false;
            navMeshAgent.enabled = false;
            moveUp = true;
            selfRigidbody.useGravity = false;
            Climb();
        }

        if (other.gameObject.CompareTag("ClimbOff"))
        {
            navMeshAgent.enabled = true;
            gotTheDestination = true;
            moveUp = false;
            selfRigidbody.useGravity = true;
            Run();
        }
    }

    public void SetDestination()
    {
        gotTheDestination = true;
        Run();
    }

    public void NoDestination()
    {
        gotTheDestination = false;
        navMeshAgent.isStopped = true;
        Idle();
    }

    void Idle()
    {
        anim.SetInteger("Player", 0);
    }

    void Run()
    {
        anim.SetInteger("Player", 1);
    }

    void Climb()
    {
        anim.SetInteger("Player", 7);
    }

    void DieFromBullet()
    {
        anim.SetInteger("Player", 6);
    }

    void DeactivateRagdoll()
    {
        selfCollider.enabled = true;
        selfRigidbody.isKinematic = false;
        selfRigidbody.useGravity = true;
        anim.enabled = true;

        for (int i = 0; i < rbs.Count; i++)
        {
            colls[i].enabled = false;
            rbs[i].isKinematic = true;
            rbs[i].useGravity = false;
        }
    }

    void ActivateRagdoll()
    {
        selfCollider.enabled = false;
        selfRigidbody.isKinematic = true;
        selfRigidbody.useGravity = false;
        anim.enabled = false;

        for (int i = 0; i < rbs.Count; i++)
        {
            colls[i].enabled = true;
            rbs[i].isKinematic = false;
            rbs[i].useGravity = true;
        }
    }

    void AddForceInRagDoll()
    {
        for (int i = 0; i < rbs.Count; i++)
        {
            int randomX = Random.Range(0, 10);
            int xPos;
            if (randomX < 5)
            {
                xPos = -1;
            }
            else
            {
                xPos = 1;
            }
            Vector3 pos = new Vector3(xPos, 1, 0);
            rbs[i].AddForce(pos * 10, ForceMode.Impulse);
        }

    }

    public void KillEnemy()
    {
        dead = true;
        this.transform.parent = null;
        gotTheDestination = false;
        EnemyDieWithRagdoll();
    }

    public void EnemyDie()
    {
        GameManager.instance.EnemyDied();
        enemyDeadRingFxPS.Play();
        enemyDeadRingFxPS.transform.parent = null;
        Destroy(this.gameObject);
    }

    public void EnemyDieWithRagdoll()
    {
        GameManager.instance.EnemyDied();
        gotTheDestination = false;
        if (navMeshAgent)
        {
            navMeshAgent.enabled = false;
        }
        ActivateRagdoll();
        AddForceInRagDoll();
        enemyDeadRingFxPS.Play();
        enemyDeadRingFxPS.transform.parent = null;
        Destroy(this.gameObject, 2);
    }
}
