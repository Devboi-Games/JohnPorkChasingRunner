using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CallStateManager : MonoBehaviour
{
    public class OnCallStateChangedEventArgs : EventArgs
    {
        public CallState _currentCallState;
    }
    public enum CallState { Ringing, Accepted, Declined, Ended }

    [SerializeField] private ControlPanel controlPanel;
    [SerializeField] private SkinShowcase skinShowcase;
    [SerializeField] private GameObject declineCallBG;
    [SerializeField] private Timer timer;
    [SerializeField] private float recallIntervalMax = 1f;

    [Header("CharacterVoices")]
    [SerializeField] private AudioClip[] walterPinkClips;
    [SerializeField] private AudioClip[] mrsPorkClips;
    [SerializeField] private AudioClip[] mrPorkClips;
    [Header("Normal SFx")]
    [SerializeField] private AudioClip[] audioClips;
    [SerializeField] private AudioSource audioSource;
    [SerializeField] private AudioSource voiceSource;
    [SerializeField] private GameObject[] startCallPages;
    [SerializeField] private GameObject[] midCallPages;

    private CallState currentCallState;
    private OnCallStateChangedEventArgs callStateChangedEventArgs = new OnCallStateChangedEventArgs();
    private bool wasAccepted;

    public event EventHandler<OnCallStateChangedEventArgs> onCallStateChanged;


    private void Start()
    {
        controlPanel.onDragToStartGame.AddListener(Ring);
    }

    private void Timer_onIsFinished(object sender, EventArgs e)
    {
        timer.onIsFinished -= Timer_onIsFinished;
        BE_Ended();
    }

    public void BE_Accept()
    {
        timer.gameObject.SetActive(true);
        wasAccepted = true;
        SetCharacterVoice(skinShowcase.CurrentSkinIndex);
        PlaySound(audioClips[1], false);
        SetState(CallState.Accepted);

        startCallPages[skinShowcase.CurrentSkinIndex].gameObject.SetActive(false);
        midCallPages[skinShowcase.CurrentSkinIndex].gameObject.SetActive(true);

        StartCoroutine(COR_StartTalking());
    }

    public void BE_Ended()
    {
        timer.gameObject.SetActive(false);
        PlaySound(audioClips[2], false);
        SetState(CallState.Ended);
        midCallPages[skinShowcase.CurrentSkinIndex].gameObject.SetActive(false);
    }

    private IEnumerator COR_StartTalking()
    {
        yield return new WaitForSeconds(.1f);


        voiceSource.Play();
        timer.onIsFinished += Timer_onIsFinished;


    }

    private void SetCharacterVoice(int currentSkinIndex)
    {
        if (currentSkinIndex == 0)
        {
            voiceSource.clip = mrPorkClips[UnityEngine.Random.Range(0, mrPorkClips.Length)];
        }
        else if (currentSkinIndex == 1)
        {
            voiceSource.clip = walterPinkClips[UnityEngine.Random.Range(0, walterPinkClips.Length)];

        }
        else if (currentSkinIndex == 2)
        {
            voiceSource.clip = mrsPorkClips[UnityEngine.Random.Range(0, mrsPorkClips.Length)];

        }
    }

    private IEnumerator COR_Ring()
    {
        yield return new WaitForSeconds(.1f);
        SetState(CallState.Ringing);
        PlaySound(audioClips[0], true);
        startCallPages[skinShowcase.CurrentSkinIndex].gameObject.SetActive(true);

    }

    private void SetState(CallState state)
    {
        currentCallState = state;
        callStateChangedEventArgs._currentCallState = currentCallState;
        onCallStateChanged?.Invoke(this, callStateChangedEventArgs);
    }

    public void BE_Decline()
    {
        PlaySound(audioClips[2], false);
        voiceSource.Stop();
        SetState(CallState.Declined);
        midCallPages[skinShowcase.CurrentSkinIndex].gameObject.SetActive(false);

        if (!wasAccepted)
        {
            StartCoroutine(COR_CallAgain());
        }
        else
        {
            Timer_onIsFinished(this, EventArgs.Empty);
        }
    }

    private IEnumerator COR_CallAgain()
    {
        startCallPages[skinShowcase.CurrentSkinIndex].gameObject.SetActive(false);
        yield return new WaitForSeconds(recallIntervalMax);
        Ring();
    }

    private void Ring()
    {
        AudioManager.Instance.gameObject.SetActive(false);
        declineCallBG.SetActive(true);
        StartCoroutine(COR_Ring());
    }

    private void PlaySound(AudioClip clip, bool loop)
    {
        audioSource.loop = loop;
        audioSource.clip = clip;
        audioSource.Play();
    }
}
