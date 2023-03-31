using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioManager : MonoBehaviour
{
    [SerializeField] private AudioSource sfxAudioSource;
    [SerializeField] private AudioClip success;
    [SerializeField] private AudioClip fail;

    public static AudioManager Instance { get; private set; }

    private void Awake()
    {
        Instance = this;
    }

    public void PlaySuccess()
    {
        sfxAudioSource.PlayOneShot(success);
    }

    public void PlayFail()
    {
        sfxAudioSource.PlayOneShot(fail);
    }
}
