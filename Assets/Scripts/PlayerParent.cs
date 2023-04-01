using UnityEngine;

public class PlayerParent : MonoBehaviour
{
    public GameObject playerPrefab;

    Transform lastPlayerPosition;
    float xPos;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.C))
        {
            InstantiatePlayers(2);
        }
        else if (Input.GetKeyDown(KeyCode.V))
        {
            InstantiatePlayers(3);
        }
    }

    public void InstantiatePlayers(int number)
    {
        lastPlayerPosition = this.transform.GetChild(this.transform.childCount - 1);
        xPos = this.transform.position.x;

        float playerZPos = lastPlayerPosition.position.z - 0.8f;
        float playerYPos = lastPlayerPosition.position.y;
        float xValue = 0;

        if (number == 2)
        {
            xValue = -0.5f;
        }
        else if (number == 3)
        {
            xValue = -1f;
        }

        for (int i = 0; i < number; i++)
        {
            Vector3 newPlayerPos = new Vector3(xValue + xPos, playerYPos, playerZPos);
            GameObject player = Instantiate(playerPrefab, newPlayerPos, Quaternion.identity, this.transform);

            if (number == 2 || number == 3)
            {
                xValue += 1;
            }
            Player playerScript = player.GetComponent<Player>();
            player.GetComponent<ChangePlayerSkin>().Init();
            playerScript.Run();
            playerScript.gameStarted = true;
        }
    }

    public void TakeOutGuns()
    {
        int totalPlayers = this.transform.childCount;

        for (int i = 0; i < totalPlayers; i++)
        {
            this.transform.GetChild(i).GetComponent<Player>().ShootBackForParent();
        }
    }

    public void TakeOutGunsForSideShow()
    {
        int totalPlayers = this.transform.childCount;

        for (int i = 0; i < totalPlayers; i++)
        {
            this.transform.GetChild(i).GetComponent<Player>().ShootSideForParent();
        }
    }

    public void PlayersHitTurretWall()
    {
        int totalPlayers = this.transform.childCount;

        for (int i = 0; i < totalPlayers; i++)
        {
            this.transform.GetChild(i).GetComponent<Player>().StopPlayer();
        }
    }

    public void MakeAllPlayerDance()
    {
        int totalPlayers = this.transform.childCount;

        for (int i = 0; i < totalPlayers; i++)
        {
            this.transform.GetChild(i).GetComponent<Player>().Win();
        }
    }

    public void MakeAllJump()
    {
        int totalPlayers = this.transform.childCount;

        for (int i = 0; i < totalPlayers; i++)
        {
            this.transform.GetChild(i).GetComponent<Player>().AllJump();
        }
    }
}
