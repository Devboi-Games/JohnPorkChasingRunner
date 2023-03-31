using System.Collections;
using UnityEngine;
using Dreamteck.Splines;
using UnityEngine.SceneManagement;

public class Player : MonoBehaviour
{
    public float runSpeed;
    public float climbSpeed;
    public float swipeSpeed;
    public float x;
    public float gunTimer;
    public int jumpForce;
    public PlayerParent playerParentScript;
    public SplineFollower splineFollower;
    public Animator anim;
    public CapsuleCollider coll;
    public Transform lookAtPoint;
    public Vector3 rotationOffset;
    public Transform enemyParent;
    public GameObject gun;
    public ParticleSystem smokeFx;

    Transform playerSpine;
    bool rotationPermission;

    Vector3 fingerPos1;
    Vector3 fingerPos2;
    float difference;
    float clampX;
    public bool gameStarted;
    bool playerControle;
    bool isAlive;
    Vector3 lookAtPointPosition;
    Rigidbody rb;

    float colliderSmallHeight = 0.68615f;
    float colliderSmallYCenter = 0.3124115f;
    float colliderActualHeight;
    float colliderActualYCenter;

    private void Awake()
    {
        anim = this.GetComponent<Animator>();
        enemyParent = GameObject.Find("/All enemies behind").transform;
        playerParentScript = this.GetComponentInParent<PlayerParent>();
        splineFollower = this.GetComponentInParent<SplineFollower>();
        rb = this.GetComponent<Rigidbody>();
        coll = this.GetComponent<CapsuleCollider>();
        colliderActualHeight = coll.height;
        colliderActualYCenter = coll.center.y;
    }

    private void Start()
    {
        playerControle = true;
        isAlive = true;
        if(playerParentScript.transform.GetChild(0).name == this.transform.name)
        {
            splineFollower.follow = false;
            splineFollower.followSpeed = runSpeed;
        }
        gun.SetActive(false);
        rotationPermission = false;
        gun.SetActive(false);
        smokeFx.Stop();
        playerSpine = anim.GetBoneTransform(HumanBodyBones.Spine);
        lookAtPointPosition = lookAtPoint.localPosition;
    }

    private void Update()
    {
        //========================== For unity Editor ==========================
#if UNITY_EDITOR
        if (Input.GetKeyDown(KeyCode.D))
        {
            Run();
        }

        if (Input.GetKeyDown(KeyCode.F))
        {
            RunBackwardAndShoot();
        }

        if(Input.GetMouseButtonDown(1))
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }
#endif
        //========================== For unity Editor ==========================




        //========================== For Mobile devices ==========================
        if (Input.GetMouseButtonDown(0) && playerControle)
        {
            fingerPos1 = Camera.main.ScreenToViewportPoint(Input.mousePosition);

            if (!gameStarted && splineFollower)
            {
                StartTheGame();
                MakeEnemyFollow();
                gameStarted = true;
                GameManager.instance.SwipeTextOff();
            }
        }

        if(Input.GetMouseButton(0) && playerControle)
        {
            fingerPos2 = Camera.main.ScreenToViewportPoint(Input.mousePosition);
            difference = (fingerPos2.x - fingerPos1.x) * swipeSpeed * Time.deltaTime;
            this.transform.localPosition -= new Vector3(difference, 0, 0);
            //clampX = Mathf.Clamp(this.transform.localPosition.x, -x, x);
            //this.transform.localPosition = new Vector3(clampX, this.transform.localPosition.y, this.transform.localPosition.z);

            fingerPos1 = fingerPos2;
        }
        clampX = Mathf.Clamp(this.transform.localPosition.x, -x, x);
        this.transform.localPosition = new Vector3(clampX, this.transform.localPosition.y, this.transform.localPosition.z);
        //========================== For Mobile devices ==========================
    }




    //========================== Trigger Events ==========================
    public void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.CompareTag("Gun"))
        {
            Destroy(other.gameObject);
            playerParentScript.TakeOutGuns();
            GameManager.instance.PlayPickUpGun();
        }

        if (other.gameObject.CompareTag("Gun 2"))
        {
            Destroy(other.gameObject);
            playerParentScript.TakeOutGunsForSideShow();
            GameManager.instance.PlayPickUpGun();
        }

        if (other.gameObject.CompareTag("Air gun"))
        {
            Destroy(other.gameObject);
            StartCoroutine(GunDelay());
        }

        if (other.gameObject.CompareTag("TurretWall"))
        {
            playerParentScript.GetComponent<SplineFollower>().enabled = false;
            playerParentScript.PlayersHitTurretWall();
            TurretWall turretWall = other.GetComponent<TurretWall>();
            this.transform.parent.position = turretWall.playerSeat.position;
            turretWall.StartTurret();
            GameManager.instance.ReduceEnemySpeed();
        }

        if(other.gameObject.CompareTag("Road Trigger"))
        {
            other.GetComponent<RoadTrigger>().OtherEnemiesStartRunning();
        }

        if(other.gameObject.CompareTag("Obstacle") && isAlive)
        {
            GotHitFromBack();
            FallForward();
        }

        if(other.gameObject.CompareTag("Wall") && isAlive)
        {
            GotHitFromBack();
            FallBackword();

        }

        if (other.gameObject.CompareTag("+2"))
        {
            other.GetComponentInParent<AddPlayer>().DestroyThis();
            playerParentScript.InstantiatePlayers(2);
        }

        if (other.gameObject.CompareTag("+3"))
        {
            other.GetComponentInParent<AddPlayer>().DestroyThis();
            playerParentScript.InstantiatePlayers(3);
        }

        if (other.gameObject.CompareTag("Jump"))
        {
            Destroy(other.gameObject);
            splineFollower.followSpeed = 10;
            playerParentScript.MakeAllJump();
            GameManager.instance.CameraChange(5);
        }

        if (other.gameObject.CompareTag("JumpOff"))
        {
            if (playerParentScript.gameObject.transform.GetChild(0).name == this.gameObject.name)
            {
                splineFollower.followSpeed = runSpeed;
                GameManager.instance.CameraChange(0);
            }
            Run();
        }

        if(other.gameObject.CompareTag("Ladder"))
        {
            MovementOff();
            Climb();
        }

        if(other.gameObject.CompareTag("ClimbOff"))
        {
            MovementOn();
            Run();
        }

        if(other.gameObject.CompareTag("Big Jump"))
        {
            splineFollower.followSpeed = 10;
            GameManager.instance.CameraChange(5);
            BigJump();
        }

        if (other.gameObject.CompareTag("Big Jump 2"))
        {
            splineFollower.followSpeed = runSpeed;
            Time.timeScale = 1;
            GameManager.instance.CameraChange(0);
            Run();
        }

        if (other.gameObject.CompareTag("Slide"))
        {
            Slide();
            if (playerParentScript.gameObject.transform.GetChild(0).name == this.gameObject.name)
            {
                splineFollower.followSpeed = 8.5f;
                GameManager.instance.CameraChange(6);
            }
        }

        if (other.gameObject.CompareTag("Slide Off"))
        {
            Run();
            if (playerParentScript.gameObject.transform.GetChild(0).name == this.gameObject.name)
            {
                splineFollower.followSpeed = runSpeed;
                GameManager.instance.CameraChange(0);
            }
        }

        if (other.gameObject.CompareTag("Slide 2"))
        {
            Slide();
            coll.height = colliderSmallHeight;
            coll.center = new Vector3(coll.center.x, colliderSmallYCenter, coll.center.z);
            if (playerParentScript.gameObject.transform.GetChild(0).name == this.gameObject.name)
            {
                splineFollower.followSpeed = 8.5f;
                GameManager.instance.CameraChange(7);
            }
        }

        if (other.gameObject.CompareTag("Slide 2 off"))
        {
            Run();
            if (playerParentScript.gameObject.transform.GetChild(0).name == this.gameObject.name)
            {
                splineFollower.followSpeed = runSpeed;
                GameManager.instance.CameraChange(0);
            }
        }

        if (other.gameObject.CompareTag("Roll jump"))
        {
            RollJump();
            rb.AddForce(Vector3.up * 8, ForceMode.Impulse);
        }

        if (other.gameObject.CompareTag("Roll jump off"))
        {
            Run();
        }
    }
    //========================== Trigger Events ==========================




    //========================== Collision Events ==========================
    private void OnCollisionEnter(Collision other)
    {
        if(other.gameObject.CompareTag("Enemy") && isAlive)
        {
            GotHitFromBack();
            FallForward();
        }
    }
    //========================== Collision Events ==========================





    private void LateUpdate()
    {
        if (rotationPermission)
        {
            playerSpine.LookAt(lookAtPoint);
            playerSpine.rotation *= Quaternion.Euler(rotationOffset);
        }
    }




    //========================== Animation Function ==========================
    public void Idle()
    {
        gun.SetActive(false);
        rotationPermission = false;
        anim.SetInteger("Player", 0);
        smokeFx.Stop();
    }

    public void Run()
    {
        gun.SetActive(false);
        this.transform.localRotation = Quaternion.Euler(0, 0, 0);
        rotationPermission = false;
        anim.SetBool("Shoot", false);
        anim.SetInteger("Player", 1);
        smokeFx.Play();
    }

    public void RunBackwardAndShoot()
    {
        gun.SetActive(true);
        this.transform.localRotation = Quaternion.Euler(0, 180, 0);
        rotationPermission = true;
        anim.SetInteger("Player", 2);
        anim.SetBool("Shoot", true);
        lookAtPoint.localPosition = lookAtPointPosition;
    }

    public void Win()
    {
        anim.SetInteger("Player", 3);
    }

    public void FallForward()
    {
        anim.SetInteger("Player", 4);
        smokeFx.Stop();
    }

    public void Jump()
    {
        anim.SetInteger("Player", 5);
        smokeFx.Stop();
    }

    public void FallBackword()
    {
        anim.SetInteger("Player", 6);
        smokeFx.Stop();
    }

    public void Climb()
    {
        anim.SetInteger("Player", 7);
        smokeFx.Stop();
    }

    public void BigJump()
    {
        anim.SetInteger("Player", 8);
        smokeFx.Stop();
        Time.timeScale = 0.5f;
        rb.AddForce(Vector3.up * 10, ForceMode.Impulse);
    }

    public void Slide()
    {
        anim.SetInteger("Player", 9);
    }

    public void RollJump()
    {
        anim.SetInteger("Player", 10);
        smokeFx.Stop();
    }
    //========================== Animation Function ==========================




    //========================== General Function ==========================

    public void ShootBackForParent()
    {
        RunBackwardAndShoot();
        StartCoroutine("RunBackwardTimeoff");
    }

    public void ShootSideForParent()
    {
        RunForwardAndShoot();
        StartCoroutine("RunBackwardTimeoff");
    }

    public void StartTheGame()
    {
        splineFollower.follow = true;
        Run();
    }

    public void StopPlayer()
    {
        if (splineFollower)
        {
            splineFollower.follow = false;
        }
        Idle(); 
        playerControle = false;
    }

    public void GotHitFromBack()
    {
        isAlive = false;
        if (playerParentScript.transform.childCount == 1)
        {
            GameManager.instance.CameraChange(3);
        }
        playerControle = false;
        rotationPermission = false;
        anim.SetBool("Shoot", false);
        gun.SetActive(false);
        StopCoroutine("RunBackwardTimeoff");
        this.transform.localRotation = Quaternion.Euler(0, 0, 0);
        if (playerParentScript.transform.childCount == 1)
        {
            splineFollower.follow = false;
            GameManager.instance.DestinationOff();
        }
        else
        {
            this.transform.parent = null;
            Destroy(this.gameObject, 3);
        }
        GameManager.instance.ChangeEnemyTarget();
        //anim.SetInteger("Player", 4);
    }

    public void RunForwardAndShoot()
    {
        gun.SetActive(true);
        rotationPermission = true;
        anim.SetBool("Shoot", true);
        if (playerParentScript.gameObject.transform.GetChild(0).name == this.gameObject.name && GameManager.instance.canChangeCamera)
        {
            GameManager.instance.CameraChange(2);
        }
        lookAtPoint.localPosition = new Vector3(-2, lookAtPointPosition.y, lookAtPointPosition.z);
    }

    public void MakeEnemyFollow()
    {
        for (int i = 0; i < enemyParent.childCount; i++)
        {
            enemyParent.GetChild(i).GetComponent<Enemy>().SetDestination();
        }
    }

    public void AllJump()
    {
        rb.AddForce(Vector3.up * jumpForce, ForceMode.Impulse);
        Jump();
    }

    void MovementOff()
    {
        rb.useGravity = false;
        rb.isKinematic = true;

        if (playerParentScript.gameObject.transform.GetChild(0).name == this.gameObject.name)
        {
            splineFollower.followSpeed = climbSpeed;
        }
    }

    void MovementOn()
    {
        rb.useGravity = true;
        rb.isKinematic = false;
        if (playerParentScript.gameObject.transform.GetChild(0).name == this.gameObject.name)
        {
            splineFollower.followSpeed = runSpeed;
        }
    }
    //========================== General Function ==========================




    //========================== IEnumerator Function ==========================
    IEnumerator RunBackwardTimeoff()
    {
        yield return new WaitForSeconds(gunTimer);
        if (playerParentScript.transform.GetChild(0).gameObject == this.gameObject && GameManager.instance.canChangeCamera)
        {
            GameManager.instance.CameraChange(0);
        }
        Run();
    }

    IEnumerator GunDelay()
    {
        yield return new WaitForSeconds(1.3f);
        playerParentScript.TakeOutGuns();
        GameManager.instance.PlayPickUpGun();
    }
    //========================== IEnumerator Function ==========================
}
