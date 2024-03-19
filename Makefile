# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY: build-push

TAG = 0.0.6
REPO = gcr.io/k8s-minikube/kube-registry-proxy

build-push:
	docker run --rm --privileged tonistiigi/binfmt:latest --install all
	docker buildx create --name multiarch --bootstrap
	docker buildx build --builder multiarch --push --platform linux/s390x,linux/ppc64le,linux/arm/v7,linux/arm64/v8,linux/amd64 -t $(REPO):$(TAG) .
	docker buildx rm multiarch
