using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LoadingPanel : MonoBehaviour
{
    [SerializeField] private ProgressBar progressBar;
    [SerializeField] private float loadDuration;

    public event EventHandler onHidden;

    private void Start()
    {
        progressBar.onFinished += ProgressBar_onFinished;
    }

    public void Show()
    {
        gameObject.SetActive(true);
        progressBar.FillUp(loadDuration);
    }

    private void ProgressBar_onFinished(object sender, System.EventArgs e)
    {
        onHidden?.Invoke(this, EventArgs.Empty);
    }
}
