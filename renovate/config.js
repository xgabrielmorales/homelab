module.exports = {
  platform: 'forgejo',
  endpoint: 'https://git.xgabrielmorales.com/api/v1/',
  token: process.env.RENOVATE_TOKEN,
  repositories: ['xgabrielmorales/homelab'],
  binarySource: 'install',
  onboarding: false,
  requireConfig: 'ignored',
  dependencyDashboard: true,
  extends: ['group:all'],
  separateMajorMinor: true,
  minimumReleaseAge: '7 days',
  minimumReleaseAgeBehaviour: 'timestamp-optional',
  prHourlyLimit: 0,
  prConcurrentLimit: 0,
  kubernetes: {
    managerFilePatterns: ['/^k8s/(apps|infra|monitoring)/.+\\.ya?ml$/']
  },
  flux: {
    managerFilePatterns: ['/^k8s/.+\\.ya?ml$/']
  },
  packageRules: [
    {
      // 2026.09.30-1454ead: the commit suffix would otherwise be treated as a fixed variant
      matchPackageNames: ['quay.io/invidious/**'],
      versioning: 'regex:^(?<major>\\d{4})\\.(?<minor>\\d{2})\\.(?<patch>\\d{2})-[0-9a-f]+$'
    },
    {
      // 12.1ubu2604-ls51
      matchPackageNames: ['linuxserver/jellyfin'],
      versioning:
        'regex:^(?<major>\\d+)\\.(?<minor>\\d+)(\\.(?<patch>\\d+))?(?<compatibility>ubu\\d+)-ls(?<build>\\d+)$'
    },
    {
      matchPackageNames: ['linuxserver/qbittorrent'],
      allowedVersions: '<10'
    }
  ],
  hostRules: [
    {
      hostType: 'github',
      token: process.env.GITHUB_TOKEN
    },
    {
      matchHost: 'docker.io',
      username: process.env.DOCKERHUB_USERNAME,
      password: process.env.DOCKERHUB_TOKEN
    },
    {
      matchHost: 'ghcr.io',
      token: process.env.GITHUB_TOKEN
    }
  ]
};
