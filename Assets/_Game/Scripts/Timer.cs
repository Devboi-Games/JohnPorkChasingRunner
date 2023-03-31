using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class Timer : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI textComp;
    [SerializeField] private AudioSource voiceSource;
    [SerializeField] private CallStateManager callStateManager;
    private DateTime currentTime;
    private float timer;
    private float timerMax;

    public event EventHandler onIsFinished;

    private void Awake()
    {
        timerMax = voiceSource.clip.length;
    }

    private void Start()
    {
        callStateManager.onCallStateChanged += CallStateManager_onCallStateChanged;
    }

    private void CallStateManager_onCallStateChanged(object sender, CallStateManager.OnCallStateChangedEventArgs e)
    {
        if (e._currentCallState == CallStateManager.CallState.Accepted)
        {
            timer = 0;
            timerMax = voiceSource.clip.length;
            currentTime = new DateTime();
            textComp.text = $"{currentTime.Minute:00}:{currentTime.Second:00}";
            Debug.Log("Reset");
        }
    }

    private void Update()
    {
        if (timer >= timerMax)
        {
            textComp.text = $"{currentTime.Minute:00}:{currentTime.Second:00}";
            onIsFinished?.Invoke(this, EventArgs.Empty);
        }
        else
        {
            timer += Time.deltaTime;
            try
            {
                currentTime = currentTime.AddSeconds(Time.deltaTime);
            }
            catch (Exception)
            {
                Debug.Log("Timer Done");
            }
            textComp.text = $"{currentTime.Minute:00}:{currentTime.Second:00}";
        }
    }
}
