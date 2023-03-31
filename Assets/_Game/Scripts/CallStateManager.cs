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
    [SerializeField] private Timer timer;
    [SerializeField] private float recallIntervalMax = 1f;

    [SerializeField] private AudioClip[] audioClips;
    [SerializeField] private AudioSource audioSource;
    [SerializeField] private AudioSource voiceSource;
    [SerializeField] private GameObject startCallPage;
    [SerializeField] private GameObject midCallPage;

    private CallState currentCallState;
    private OnCallStateChangedEventArgs callStateChangedEventArgs = new OnCallStateChangedEventArgs();

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
        PlaySound(audioClips[1], false);
        SetState(CallState.Accepted);
        startCallPage.gameObject.SetActive(false);
        midCallPage.gameObject.SetActive(true);
        StartCoroutine(COR_StartTalking());
    }

    public void BE_Ended()
    {

        PlaySound(audioClips[2], false);
        SetState(CallState.Ended);
        midCallPage.gameObject.SetActive(false);
    }

    private IEnumerator COR_StartTalking()
    {
        yield return new WaitForSeconds(.1f);
        voiceSource.Play();
        timer.onIsFinished += Timer_onIsFinished;


    }

    private IEnumerator COR_Ring()
    {
        yield return new WaitForSeconds(.1f);
        SetState(CallState.Ringing);
        PlaySound(audioClips[0], true);
        startCallPage.gameObject.SetActive(true);

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
        midCallPage.gameObject.SetActive(false);

        StartCoroutine(COR_CallAgain());
    }

    private IEnumerator COR_CallAgain()
    {
        startCallPage.gameObject.SetActive(false);
        yield return new WaitForSeconds(recallIntervalMax);
        Ring();
    }

    private void Ring()
    {
        AudioManager.Instance.gameObject.SetActive(false);
        StartCoroutine(COR_Ring());
    }

    private void PlaySound(AudioClip clip, bool loop)
    {
        audioSource.loop = loop;
        audioSource.clip = clip;
        audioSource.Play();
    }
}
