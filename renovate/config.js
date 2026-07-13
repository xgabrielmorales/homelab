module.exports = {
  platform: 'forgejo',
  endpoint: 'https://git.xgabrielmorales.com/api/v1/',
  token: process.env.RENOVATE_TOKEN,
  repositories: ['xgabrielmorales/homelab'],
  binarySource: 'install',
  onboarding: false,
  requireConfig: 'ignored',
  kubernetes: {
    managerFilePatterns: ['/^k8s/(apps|infra|monitoring)/.+\\.ya?ml$/']
  },
  flux: {
    managerFilePatterns: ['/^k8s/.+\\.ya?ml$/']
  },
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
